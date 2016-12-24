require 'minitest/autorun'
require 'minitest/pride'
require './lib/person'

class PersonTest < Minitest::Test

  def test_it_has_a_class
    person1 = Person.new("Minerva", 1000)
    assert_instance_of Person, person1
  end

  def test_it_has_a_name
    person1 = Person.new("Minerva", 1000)
    assert_equal "Minerva", person1.name
  end

  def test_it_can_have_other_names
    person2 = Person.new("Luna", 500)
    assert_equal "Luna", person2.name
  end

  def test_it_has_cash
    person1 = Person.new("Minerva", 1000)
    assert_equal 1000, person1.cash
  end

  def test_it_has_cash
    person2 = Person.new("Luna", 500)
    assert_equal 500, person2.cash
  end

  def test_it_displays_person_creation_message
    person1 = Person.new("Minerva", 1000)
    expected = "Minerva has been created with 1000 galleons."
    assert_equal expected, person1.create_person
  end

  def test_it_displays_another_person_creation_message
    person2 = Person.new("Luna", 500)
    expected = "Luna has been created with 500 galleons."
    assert_equal expected, person2.create_person
  end
end
