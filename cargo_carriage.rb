require_relative 'carriages'
require_relative 'validation'
class CargoCarriage < Carriage
  include Validation
  attr_reader :type, :availiable_place, :use_place

  validate(:carr_num, :presence)
  validate(:carr_num, :format, CARRIAGE_NAMBER_FORMAT)

  def initialize(carr_num, cargo = 10)
    super
    @carr_num = carr_num
    @type = :cargo
    @availiable_goods = cargo
    @use_place = 0.0
    validate!
  end

  def add_good(goods)
    @use_place += goods if @use_place < @availiable_goods
    nil if @use_place >= @availiable_goods
  end

  def show_avaliable
    @availiable_goods - @use_place
  end

  def show_use
    @use_place
  end
end
