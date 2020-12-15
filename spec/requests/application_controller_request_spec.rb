require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  controller do
    def check_input(input)
      super input
    end
  end

  describe 'check_input' do
    context ' return string with error' do
      context 'string input' do
        it "is exected to return 'Input of zero wil have no effect!'" do
          expect(controller.check_input('0.0')).to eq('Input of zero wil have no effect!')
        end

        it "is exected to return 'Input of negative numbers is not allowed!'" do
          expect(controller.check_input('-1.0')).to eq('Wrong intput format!')
        end

        it "is exected to return 'Input of negative numbers is not allowed!'" do
          expect(controller.check_input('2.00e+99999')).to eq('A liar is detected! It is impossible for you to have such sum of money nowadays!')
        end

        context 'pattern check' do 
          it "is exected to return 'Wrong intput format!'" do
            expect(controller.check_input('2.001')).to eq('Wrong intput format!')
            expect(controller.check_input('2dfgdfg234.00')).to eq('Wrong intput format!')
            expect(controller.check_input('.001')).to eq('Wrong intput format!')
            expect(controller.check_input('2.00e-12')).to eq('Wrong intput format!')
            expect(controller.check_input('2.00e-199999')).to eq('Wrong intput format!')
          end
        end
      end

      context 'float input' do
        it "is exected to return 'Input of zero wil have no effect!'" do
            expect(controller.check_input(0.0)).to eq('Input of zero wil have no effect!')
          end

          it "is exected to return 'Input of negative numbers is not allowed!'" do
            expect(controller.check_input(-1.0)).to eq('Wrong intput format!')
          end

          it "is exected to return 'Input of negative numbers is not allowed!'" do
            expect(controller.check_input(2.00e+99999)).to eq('Wrong intput format!')
          end

          context 'pattern check' do
            it "is exected to return 'Wrong intput format!'" do
              expect(controller.check_input(2.001)).to eq('Wrong intput format!')
              expect(controller.check_input(2.00e-12)).to eq('Wrong intput format!')
              expect(controller.check_input(2.00e-199999)).to eq('Input of zero wil have no effect!')
            end
          end
      end
    end
  end
end
