module PostSerializers
  class PostSerializer < ActiveModel::Serializer
    attributes :title, :content
  end
end
