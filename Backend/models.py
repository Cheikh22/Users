from sqlalchemy import Boolean, Column, Integer, String
from database import Base

class User(Base):

    __tablename__ = "user"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String)
    email = Column(String, unique=True, index=True)
    password = Column(String)
    is_Active =Column(Boolean, default=True)