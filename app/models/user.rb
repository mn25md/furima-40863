class User < ApplicationRecord
  # Deviseのモジュールを使用
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションの設定
  validates :nickname, presence: true
  validates :birth_date, presence: true
  validates :password, length: { minimum: 6 },
                       format: {
                         with: /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/,
                         message: 'is invalid. Include both letters and numbers'
                       }, if: :password_required?
  validates :password_confirmation, presence: true, if: :password_required?

  validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龠々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :first_name, presence: true,
                         format: { with: /\A[ぁ-んァ-ヶ一-龠々ー]+\z/, message: 'is invalid. Input full-width characters' }
  validates :last_name_kana, presence: true,
                             format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }
  validates :first_name_kana, presence: true,
                              format: { with: /\A[ァ-ヶー－]+\z/, message: 'is invalid. Input full-width katakana characters' }

  private

  # パスワードが必要かどうかを判断するメソッド
  def password_required?
    !password.nil? || !password_confirmation.nil?
  end
end
