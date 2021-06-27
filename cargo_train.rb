require_relative 'train'
require_relative 'counter'
require_relative 'validation'
class CargoTrain < Train
  include Validation

  validate(:train_num, :presence)
  validate(:train_num, :format, TRAIN_NUMBER_FORMAT)

  def initialize(train_num)
    super
    @type = :cargo
    validate!
  end
end
