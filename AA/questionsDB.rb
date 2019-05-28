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

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options['author_id']
  end

end

class User
  attr_accessor :fname, :lname 
  def self.find_by_id(id)
     User = QuestionsDatabase.instance.execute(<<-SQL, id)
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




