require 'sqlite3'
require 'singleton'

class QuestionsDatabase < SQLite3::Database 
  include Singleton

  def initialize
    super('questions.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Question
  attr_accessor :title, :body, :author_id

   def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    data.map { |datum| Question.new(datum) }
   end

  def self.find_by_id(id)
     
     question = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM  
        questions
      WHERE
        id = ?
    SQL

    Question.new(question.first)
  end

  def self.find_by_author_id(author_id)
      author = QuestionsDatabase.instance.execute(<<-SQL, author_id)
        SELECT
          users.fname
        FROM
          questions
        WHERE
          author_id = ?
      SQL

  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

end

class User
  attr_accessor :fname, :lname 

  def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    data.map { |datum| User.new(datum) }
  end

  def self.find_by_id(id)
     user = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM  
        users
      WHERE
        id = ?
    SQL

     User.new(user.first)
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
end

class Reply
  attr_accessor :body, :subject_question_id, :parent_id, :original_author_id

   def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    data.map { |datum| Reply.new(datum) }
   end

  def self.find_by_id(id)
     
     reply = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM  
        replies
      WHERE
        id = ?
    SQL

    Reply.new(reply.first)
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @subject_question_id = options['subject_question_id']
    @parent_id = options['parent_id']
    @original_author_id = options['original_author_id']
  end

end


class Like
  attr_accessor :likes, :likes_user_id, :likes_question_id

   def self.all
    data = QuestionsDatabase.instance.execute("SELECT * FROM likes")
    data.map { |datum| Like.new(datum) }
   end

  def self.find_by_id(id)
     
     like = QuestionsDatabase.instance.execute(<<-SQL, id)
      SELECT
        *
      FROM  
        likes
      WHERE
        id = ?
    SQL

    Like.new(like.first)
  end

  def initialize(options)
    @id = options['id']
    @likes = options['likes']
    @likes_user_id = options['likes_user_id']
    @likes_question_id = options['likes_question_id']
  end

end




