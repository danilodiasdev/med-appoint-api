"""create schedule table

Revision ID: 873750f4b7c2
Revises: acf285941aef
Create Date: 2026-02-14 23:44:49.075672

"""

from typing import Sequence, Union



# revision identifiers, used by Alembic.
revision: str = "873750f4b7c2"
down_revision: Union[str, Sequence[str], None] = "acf285941aef"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
