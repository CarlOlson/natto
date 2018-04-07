# coding: utf-8
require 'open3'
require 'rbconfig'

class TestDictionaryInfo < Minitest::Test
  def setup
    m = Natto::MeCab.new()
    refute_nil(m, "FAIL! No good dictionary")
    @dicts = m.dicts
  end

  def teardown
    @dicts = nil
  end

  # Tests the dictionaries accessor method of Natto::MeCab.
  def test_dictionaries_accessor
    assert @dicts.empty? == false
    sysdic = @dicts.first
    assert_equal(0, sysdic[:type])
    assert(sysdic[:filename].size > 0)
    assert(sysdic[:charset] =~ /UTF-8/)
  end

  def test_to_s
    assert(@dicts.first.to_s.include? 'filepath=')
    assert(@dicts.first.to_s.include? 'charset=')
    assert(@dicts.first.to_s.include? 'type=')
  end

  # Note: Object#type is deprecated in 1.9.n, but comes with a warning
  #       in 1.8.n
  def test_dictionary_info_member_accessors
    sysdic = @dicts.first
    members = [
      :filename,
      :charset,
      :size,
      :lsize,
      :rsize,
      :version,
      :next
    ]
    members << :type if RUBY_VERSION.to_f < 1.9
    members.each do |nomme|
      refute_nil(sysdic.send nomme)
    end

    assert_raises NoMethodError do
      sysdic.send :unknown_attr
    end
  end

  def test_is
    assert @dicts[0].is_sysdic? == true
    assert @dicts[0].is_usrdic? == false
    assert @dicts[0].is_unkdic? == false
  end
end

# Copyright (c) 2016, Brooke M. Fujita.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
#  * Redistributions of source code must retain the above
#    copyright notice, this list of conditions and the
#    following disclaimer.
#
#  * Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the
#    following disclaimer in the documentation and/or other
#    materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
# WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
# ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
# SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
