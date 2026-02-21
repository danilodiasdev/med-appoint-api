"""create schedule table

Revision ID: acf285941aef
Revises:
Create Date: 2026-02-14 23:24:06.542177

"""

from typing import Sequence, Union


# revision identifiers, used by Alembic.
revision: str = "acf285941aef"
down_revision: Union[str, Sequence[str], None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
