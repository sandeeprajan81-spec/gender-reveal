
-- Store guests' names and guesses
CREATE TABLE public.baby_guesses (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  guest_name text NOT NULL
    CHECK (char_length(guest_name) BETWEEN 1 AND 60),
  guess text NOT NULL
    CHECK (guess IN ('Boy', 'Girl')),
  created_at timestamptz DEFAULT now()
);

-- Enable database security
ALTER TABLE public.baby_guesses
ENABLE ROW LEVEL SECURITY;

-- Guests may submit guesses
GRANT INSERT ON public.baby_guesses TO anon;

CREATE POLICY "Guests can submit guesses"
ON public.baby_guesses
FOR INSERT
TO anon
WITH CHECK (true);

-- No public SELECT policy:
-- Guests cannot read the saved guesses.
