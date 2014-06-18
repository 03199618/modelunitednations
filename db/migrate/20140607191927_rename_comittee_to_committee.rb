class RenameComitteeToCommittee < ActiveRecord::Migration
  def change
    rename_table :comittee_sessions, :committee_sessions
    rename_column :committee_sessions, :comittee_id, :committee_id

    rename_table :comittees, :committees

    rename_table :comittees_participants, :committees_participants
    rename_column :committees_participants, :comittee_id, :committee_id

    rename_table :comittees_topics, :committees_topics
    rename_column :committees_topics, :comittee_id, :committee_id

    rename_column :committee_members, :comittee_id, :committee_id

    rename_column :delegates, :comittee_id, :committee_id

    rename_column :resolutions, :comittee_id, :committee_id


  end
end
