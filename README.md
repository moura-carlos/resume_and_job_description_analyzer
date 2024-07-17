# Resume and Job Description Analyzer

## Description

This project is a web application that analyzes resumes against job descriptions. It extracts skills from both documents, compares them, and provides insights to help job seekers optimize their resumes for specific job applications.

## Features

- Upload and analyze resumes and job descriptions
- Extract skills from both documents
- Compare skills and calculate a match score
- Provide overall analysis and recommendations
- Generate ATS (Applicant Tracking System) optimization tips
- View and manage previous analyses

## Technologies Used

- Ruby on Rails
- OpenAI API (GPT-3.5-turbo model)

## Setup

1. Clone the repository
2. Install dependencies:
   bundle install
3. Set up your database:
   rails db:create db:migrate
4. Set up your OpenAI API key:

- Add your OpenAI API key to your Rails credentials

## Usage

1. Start the Rails server:
   rails server
2. Navigate to `http://localhost:3000` in your web browser
3. Use the interface to upload a resume and job description
4. View the analysis results, including matching skills, missing skills, match score, and ATS tips

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
