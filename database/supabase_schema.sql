create table if not exists users (
    id text primary key,
    email text not null unique,
    full_name text not null,
    role text not null check (role in ('admin', 'user')),
    password_hash text not null,
    created_at timestamp without time zone not null default now()
);

create table if not exists quizzes (
    id text primary key,
    creator_id text not null references users(id),
    title text not null,
    description text,
    subject text not null,
    time_limit_minutes integer not null,
    status text not null check (status in ('draft', 'published', 'closed')),
    quiz_code text not null unique,
    monitoring_enabled boolean not null default false,
    scheduled_start timestamp without time zone,
    scheduled_end timestamp without time zone,
    created_at timestamp without time zone not null default now()
);

create table if not exists questions (
    id text primary key,
    quiz_id text not null references quizzes(id) on delete cascade,
    question_text text not null,
    question_type text not null check (question_type in ('multiple_choice', 'true_false', 'short_answer')),
    points integer not null default 1,
    sort_order integer not null default 0,
    created_at timestamp without time zone not null default now()
);

create table if not exists question_options (
    id text primary key,
    question_id text not null references questions(id) on delete cascade,
    option_text text not null,
    is_correct boolean not null default false,
    sort_order integer not null default 0,
    created_at timestamp without time zone not null default now()
);

create table if not exists quiz_attempts (
    id text primary key,
    quiz_id text not null references quizzes(id) on delete cascade,
    student_id text not null references users(id),
    score integer not null default 0,
    percentage numeric(5,2) not null default 0,
    status text not null check (status in ('in_progress', 'submitted', 'auto_submitted')),
    started_at timestamp without time zone not null,
    submitted_at timestamp without time zone,
    consent_given boolean not null default false,
    created_at timestamp without time zone not null default now()
);

create table if not exists student_responses (
    id text primary key,
    attempt_id text not null references quiz_attempts(id) on delete cascade,
    question_id text not null references questions(id) on delete cascade,
    selected_option text,
    text_response text,
    is_correct boolean not null default false,
    created_at timestamp without time zone not null default now()
);

create table if not exists activity_logs (
    id text primary key,
    quiz_id text not null references quizzes(id) on delete cascade,
    attempt_id text not null references quiz_attempts(id) on delete cascade,
    event_type text not null,
    event_description text not null,
    flag_level text not null default 'low' check (flag_level in ('low', 'medium', 'high')),
    reviewed boolean not null default false,
    instructor_notes text,
    created_date timestamp without time zone not null default now()
);