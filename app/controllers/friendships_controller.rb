class FriendshipsController < ApplicationController
  def index
    friends = Friendship.where("user_id = ? or friend_id = ?", current_user.id, current_user.id).order(created_at: 'desc')
    @friends = friends.reject{|e| e[:reject] == true }
  end

  def approval_list
    @requests = Friendship.where(friend_id: current_user.id, accept: nil, reject: nil).order(created_at: 'desc')
  end

  def approve
    request = Friendship.find(params[:id])
    request.accept = true
    request.save
    redirect_to friend_request_approval_path
  end

  def reject
    request = Friendship.find(params[:id])
    request.reject = true
    request.save
    redirect_to friend_request_approval_path
  end

end
