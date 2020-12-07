require 'rails_helper'

RSpec.describe UsersHistoryRecord, type: :model do

  context 'check transaction for ' do
   it{ is_expected.to belong_to(:user)}
  end
end
