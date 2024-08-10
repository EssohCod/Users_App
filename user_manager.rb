require 'sqlite3'

class UserManager
  DB_FILE = 'database.sqlite'

  def initialize
    @db = SQLite3::Database.new(DB_FILE)
    setup_users_table
  end

  def setup_users_table
    query = <<-SQL
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        firstname TEXT,
        lastname TEXT,
        age INTEGER,
        password TEXT,
        email TEXT
      );
    SQL
    @db.execute(query)
  end

  def add_user(user_data)
    @db.execute("INSERT INTO users (firstname, lastname, age, password, email) VALUES (?, ?, ?, ?, ?)", user_data)
    @db.last_insert_row_id
  end

  def get_user(user_id)
    result = @db.get_first_row("SELECT * FROM users WHERE id = ?", user_id)
    result ? Hash[%w{id firstname lastname age password email}.zip(result)] : nil
  end

  def find_user_by_email(email)
    result = @db.get_first_row("SELECT * FROM users WHERE email = ?", email)
    result ? Hash[%w{id firstname lastname age password email}.zip(result)] : nil
  end

  def fetch_all_users
    @db.execute("SELECT id, firstname, lastname, age, email FROM users").map do |row|
      Hash[%w{id firstname lastname age email}.zip(row)]
    end
  end

  def change_user_password(user_id, new_password)
    @db.execute("UPDATE users SET password = ? WHERE id = ?", new_password, user_id)
    get_user(user_id)
  end

  def delete_user(user_id)
    @db.execute("DELETE FROM users WHERE id = ?", user_id)
  end
end
