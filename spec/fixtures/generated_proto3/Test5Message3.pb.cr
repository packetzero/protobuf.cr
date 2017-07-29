## Generated from Test4Message3.proto for com.acme.proto3
#require "protobuf"

module TestMessagesProto3

  struct Test5
    include Protobuf::Message

    contract_of "proto3" do
      repeated :d, :int32, 4
      optional :name, :string, 32
      optional :ipaddr, :bytes, 4
    end

    with_to_json
  end

end
