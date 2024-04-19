-- migrate:up
CALL electric.migration_version('20240411054320');

CREATE TABLE issue (
    id UUID PRIMARY KEY,
    "title" TEXT
);

ALTER TABLE issue ENABLE ELECTRIC;

-- migrate:down

