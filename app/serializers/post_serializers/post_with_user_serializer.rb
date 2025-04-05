module PostSerializers
  class PostWithUserSerializer < ActiveModel::Serializer
    attributes :id, :title, :content

    belongs_to :user, serializer: UserSerializers::UserSerializer
  end
end
