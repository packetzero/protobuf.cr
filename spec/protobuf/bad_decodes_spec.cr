require "../spec_helper"

# Test how we handle bad/invalid data

describe "Protobuf::Message" do
  it "Decode varint larger than 64-bits" do

    io = IO::Memory.new()
    b = "08878787878787878787878787878787878787878787".hexbytes
    io.write(b)
    io.rewind
    expect_raises do
      msg = TestMessagesProto3::Test1.from_protobuf(io)
    end
  end

  it "Decode field num invalid" do

    io = IO::Memory.new()
    b = "000000".hexbytes
    io.write(b)
    io.rewind
    expect_raises do
      msg = TestMessagesProto3::Test1.from_protobuf(io)
    end
  end


  it "length-encoded empty string" do

    io = IO::Memory.new()
    b = "1200".hexbytes
    io.write(b)
    io.rewind
    msg = TestMessagesProto3::Test2.from_protobuf(io)
    msg.b.nil?.should be_false
    msg.b.not_nil!.should eq ""

  end


    it "repeated (packed) with no elements" do

      # The encoder should not place empty repeated fields,
      # but decoder should handle it.

      io = IO::Memory.new()
      b = "2200".hexbytes
      io.write(b)
      io.rewind
      msg = TestMessagesProto3::Test4.from_protobuf(io)
      msg.d.nil?.should be_false
      msg.d.not_nil!.size.should eq 0

    end

end
