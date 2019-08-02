class Api::V1::UserChatsController < ApplicationController
  before_action :authenticate_user

end
