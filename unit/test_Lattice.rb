#!ruby -Ku

require 'test/unit'
require 'Lattice'
require 'pp'

class TestLattice < Test::Unit::TestCase

  include Lattice

  def setup
  end

  def teardown
  end

  def test_g_size
    g_size(["a","aaa"],[["bbb","b"],["cc","cc"]])
  end

  def test_g_line
    g_line([10,10,20])
  end

  def test_g_data
    g_data([["aaa","bbb","ccc"],["ddd","eee","fff"]],[10,10,20],["","",""])
  end

  def test_1
    lattice("data"=>[[1000,"abcde","12345"],[2000,"fghij","67890"]],
            "col"=> ["id","key","value"],
            "size"=>[10,20,20],
            "ini"=> ["","",""]
           )
  end

end

