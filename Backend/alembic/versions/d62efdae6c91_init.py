"""init

Revision ID: d62efdae6c91
Revises: 
Create Date: 2021-12-09 16:16:50.679657

"""
from sqlalchemy.sql.expression import false
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'd62efdae6c91'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    op.create_table('user',
    sa.Column('id',sa.Integer, primary_key=True),
    sa.Column('name',sa.String,nullable=False),
    sa.Column('email',sa.String,nullable=False),
    sa.Column('password',sa.String,nullable=False),
    sa.Column('is_Active',sa.Boolean,nullable=False)
    )


def downgrade():
    op.drop_table('user')
