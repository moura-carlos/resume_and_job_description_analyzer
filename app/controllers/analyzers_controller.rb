class AnalyzersController < ApplicationController
  def new
    @analyzer = Analyzer.new
    @analyzer.build_resume
    @analyzer.build_job_description
  end

  def show
    @analyzer = Analyzer.find(params[:id])
    @analysis = @analyzer.analysis
  end

  def index
    @analyzers = Analyzer.all
  end

  def create
    @analyzer = Analyzer.new(analyzer_params)
    if @analyzer.save
      analysis_results = analyze_resume(@analyzer.resume.content, @analyzer.job_description.content)
      @analysis = Analysis.create(
        content: analysis_results[:content],
        matching_skills: analysis_results[:matching_skills].join(", "),
        missing_skills: analysis_results[:missing_skills].join(", "),
        match_score: analysis_results[:match_score],
        ats_tips: analysis_results[:ats_tips],
        analyzer: @analyzer
      )
      redirect_to @analyzer, notice: 'Analyzer was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @analyzer = Analyzer.find(params[:id])
    @analyzer.destroy
    redirect_to analyzers_path, notice: 'Analyzer was successfully deleted.'
  end

  private

  def analyzer_params
    params.require(:analyzer).permit(
      resume_attributes: [:content],
      job_description_attributes: [:content]
    )
  end

  def analyze_resume(resume, job_description)
    client = get_client

    # Extract skills from resume and job description
    resume_skills = extract_skills(resume, client)
    job_skills = extract_skills(job_description, client)

    # Log extracted skills for debugging
    Rails.logger.debug "Resume Skills: #{resume_skills.inspect}"
    Rails.logger.debug "Job Skills: #{job_skills.inspect}"

    # Convert skills to lowercase for case-insensitive comparison
    resume_skills_lower = resume_skills.map(&:downcase)
    job_skills_lower = job_skills.map(&:downcase)

    # Compare skills and generate analysis content
    matching_skills = resume_skills_lower & job_skills_lower
    missing_skills = job_skills_lower - resume_skills_lower
    match_score = (matching_skills.size.to_f / job_skills_lower.size * 100).round(2)

    # Convert matching_skills back to original case from job_skills
    matching_skills = job_skills.select { |skill| matching_skills.include?(skill.downcase) }
    missing_skills = job_skills.select { |skill| missing_skills.include?(skill.downcase) }

    # Log match score for debugging
    Rails.logger.debug "Matching Skills: #{matching_skills.inspect}"
    Rails.logger.debug "Missing Skills: #{missing_skills.inspect}"
    Rails.logger.debug "Match Score: #{match_score}"

    # Generate overall analysis using OpenAI
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful assistant that compares resumes with job descriptions and provides recommendations. Exclude matching and missing skills from the recommendations." },
          { role: "user", content: "Compare the following resume with the job description and provide recommendations:\n\nResume:\n#{resume}\n\nJob Description:\n#{job_description}\n\nRecommendations:" }
        ],
        max_tokens: 150
      }
    )
    overall_analysis = response.dig("choices", 0, "message", "content")

    # Generate ATS optimization tips
    ats_tips = generate_ats_tips(resume, client)

    { content: overall_analysis, matching_skills: matching_skills, missing_skills: missing_skills, match_score: match_score, ats_tips: ats_tips }
  end


  def extract_skills(content, client)
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are a helpful assistant that extracts relevant skills from a given text. List each skill on a new line." },
          { role: "user", content: "Extract the skills from the following text:\n\n#{content}" }
        ],
        max_tokens: 150
      }
    )

    skills_text = response.dig("choices", 0, "message", "content")
    skills = skills_text.split("\n").map(&:strip).reject(&:empty?)

    skills
  end


  def generate_ats_tips(resume, client)
    response = client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [
          { role: "system", content: "You are an expert in resume optimization for Applicant Tracking Systems (ATS)." },
          { role: "user", content: "Provide tips for optimizing the following resume for ATS:\n\n#{resume}" }
        ],
        max_tokens: 150
      }
    )

    response.dig("choices", 0, "message", "content")
  end

  def get_client
    OpenAI::Client.new(
      access_token: Rails.application.credentials[:OPENAI_API_KEY],
      log_errors: true
    )
  end
end
