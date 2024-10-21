CREATE TABLE `projeto.dataset.catfacts` (
    id_catfact STRING NOT NULL,     -- [id] Unique ID for the Fact
    int_version INT64 NOT NULL,     -- [_v] Version number of the Fact
    id_user STRING NOT NULL,        -- [user] ID of the User who added the Fact
    tx_catfact STRING NOT NULL,     -- [text] The Fact itself
    dt_updated TIMESTAMP NOT NULL,  -- [updatedAt] Date in which Fact was last modified
    dt_send TIMESTAMP,              -- [sendDate] If the Fact is meant for one time use, this is the date that it is used
    is_deleted BOOLEAN NOT NULL,    -- [deleted] Whether the Fact has been soft-deleted
    tx_source STRING,               -- [source] Source from which the fact was found. Typically a URL
    tx_type STRING NOT NULL,        -- [type] Type of animal the Fact describes (e.g. ‘cat’, ‘dog’, ‘horse’)
    is_status_verified BOOLEAN,     -- [status.verified] Whether the fact has been appproved or rejected. null indicates pending status
    tx_status_feedback STRING,      -- [status.feedback] Reason for the fact being approved or rejected
    int_status_sentCount INT64      -- [status.sentCount] The number of times the Fact has been sent by the CatBot
);
