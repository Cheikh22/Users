from fastapi import FastAPI, Depends, status, Response, HTTPException
from fastapi.middleware.cors import CORSMiddleware
from sqlalchemy.orm import Session
import schemas
from database import engine , SessionLocal
import models

models.Base.metadata.create_all(engine)

app = FastAPI()

app.add_middleware(
     CORSMiddleware,
     allow_origins="*",
     allow_credentials=True,
     allow_methods=["*"],
     allow_headers=["*"],
)

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

# add user
@app.post("/user", status_code=status.HTTP_201_CREATED, tags=["user"])
def create_user(request: schemas.User,db :Session = Depends(get_db)):
    new_user =models.User(name=request.name,email=request.email,password=request.password)
    db.add(new_user)
    db.commit()
    db.refresh(new_user)
    return new_user

# get users
@app.get("/users", tags=["user"])
def read_user_list(db :Session = Depends(get_db)):
    users = db.query(models.User).all()
    return users

# get user by id
@app.get("/user/{id}", tags=["user"])
def read_user(id, db :Session = Depends(get_db)):
    user = db.query(models.User).filter(models.User.id == id).first()
    if not user:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
        detail=f"User with the id {id} is not available"
        )
    return user

# update user
@app.put("/user/{id}", status_code=status.HTTP_202_ACCEPTED, tags=["user"])
def update_user(id, request: schemas.User,db :Session = Depends(get_db)):
    user=db.query(models.User).filter(models.User.id == id)
    if not user.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
        detail=f"User with the id {id} is not available"
        )
    user.update(request.__dict__)
    db.commit()
    return 'User updated'

# delete user
@app.delete("/user/{id}", status_code=status.HTTP_204_NO_CONTENT, tags=["user"])
def delete_user(id, db :Session = Depends(get_db)):
    user=db.query(models.User).filter(models.User.id == id)
    if not user.first():
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND,
        detail=f"User with the id {id} is not available"
        )
    user.delete(synchronize_session=False)
    db.commit()
    return f"User with id {id} is deleted"
