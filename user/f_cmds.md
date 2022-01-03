# notes
Authentification
gestion de notes locale
gestion de contact locale
gestion des users exterieur
gestion des photos donnees locale
partie map avec des donnees locale
gestion des video donnees exterieur


# Run flutter project
cd Flutter/Notes
emulator -avd Pixel_2_API_26
flutter run

# run fastapi server
cd Backend
.\venv\Scripts\activate 
uvicorn main:app --reload

# run postgres database
psql -h localhost -d users -U postgres -W

# create  virtual environment, install dependences
cd Backend
python -m venv venv 
.\venv\Scripts\activate 
pip install fastapi
pip install uvicorn[standard]
pip install sqlalchemy
pip install psycopg2-binary 
pip install alembic
pip install passlib
pip install --upgrade bcrypt

# to fix script
Set-ExecutionPolicy Unrestricted -Scope Process 
