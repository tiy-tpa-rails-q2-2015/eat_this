require 'minitest/autorun'
require 'yaml'

require 'review'

class ReviewTest < MiniTest::Test

  def setup
    @data = YAML.load_file('./reviews.yml')
    @review = Review.all.first
  end

  def test_all_reviews_count
    assert_equal @data.size, Review.all.size
  end

  def test_first_review_is_a_review
    assert_kind_of Review, @review
  end

  def test_first_review_has_name
    assert_equal "Sal Manelli's", @review.name 
  end

  def test_first_review_has_url
    assert_equal "/review/1", @review.url
  end

  def test_finding_reviews
    assert_equal @review, Review.find(1)
  end

  def test_saving_changes_to_a_review
    new_name = "Rowdie's Den"

    review = Review.find(2)

    review.name = new_name
    review.save

    assert_equal new_name, Review.find(2).name

    review.name = "Rowdie's"
    review.save
  end

  def test_creating_a_new_review
    review = Review.new({
                            "name" => "Publix",
                            "image" => "publix.jpg",
                            "body" => "Their subs are the best!"
                        })
    saved = review.save
    assert_equal "Publix", Review.find(saved.id).name
  end

  def teardown
    `git checkout reviews.yml`
  end
end