module UserSerializers
  class UserSerializer < ActiveModel::Serializer
    attributes :email, :name, :role
  end
end
