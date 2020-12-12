require 'rails_helper'

RSpec.describe UsersHistoryRecord, type: :model do
<<<<<<< HEAD

  context 'check transaction for ' do
   it{ is_expected.to belong_to(:user)}
=======
  context 'check transaction for ' do
    it { is_expected.to belong_to(:user) }
>>>>>>> upstream/main
  end
end
