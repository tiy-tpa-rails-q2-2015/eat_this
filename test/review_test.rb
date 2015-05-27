require 'minitest/autorun'
require 'yaml'

require 'review'

class ReviewTest < MiniTest::Test

  def setup
    @data = YAML.load_file('./data.yml')['fresh_reviews']
  end

  def test_all_reviews_count
    assert_equal @data.size, Review.all.size
  end

  def test_first_review_is_a_review
    assert_kind_of Review, Review.all.first
  end

  def test_first_review_has_name
    assert_equal "Sal Manelli's", Review.all.first.name
  end

  def test_first_review_has_url
    assert_equal "/review/1", Review.all.first.url
  end
end