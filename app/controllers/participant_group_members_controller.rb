class ParticipantGroupMembersController < ApplicationController
  def destroy
    @member = ParticipantGroupMember.find(params[:id])
    authorize! :destroy, @member

    @group = @member.participant_group

    @member.destroy
    flash[:success] = t("pariticipant_group_member.sucessfullyDeleted")
    redirect_to @group
  end
end
