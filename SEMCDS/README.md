# SEMCDS

Smart Exam Management & Cheating Detection System prototype built with Flask.

## Run

```powershell
python -m venv .venv
.venv\Scripts\Activate.ps1
pip install -r requirements.txt
python main.py
```

To run it with the Flask CLI instead, use:

```powershell
flask --app wsgi run --debug
```

## Supabase Setup

1. Create a Supabase project.
2. Run [database/supabase_schema.sql](database/supabase_schema.sql) in the SQL editor.
3. Set `SUPABASE_URL` and `SUPABASE_SERVICE_ROLE_KEY` in your `.env` file.
4. Restart the Flask app.

## Demo Login

- Instructor: `/signin/admin`
- Student: `/signin/user`

## Notes

- The app uses a Flask application factory in `src/app.py`.
- When Supabase credentials are present, the app reads and writes quiz data through Supabase and seeds demo users there.
- Base44 login remains a placeholder; the AI question generation and quiz workflow are wired into the Flask routes.
