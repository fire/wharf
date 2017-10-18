defmodule WharfexTest do
  use ExUnit.Case
  doctest Wharfex 

  test "greets the world" do
    assert Wharfex.hello() == :world
    assert make_test_dir("test_dir")
  end
  
  def test_sym_link() do
    {os, _} = :os.type()
    case os do
      :win32 -> false
      _ -> true
    end
  end

  def create_link(dir, name, dest) do
    if test_sym_link() do
      File.ln!(Path.join(dir, dest), Path.join(dir, name))
    end
  end

  def make_test_dir(dir) do
    File.mkdir!(dir)
    File.chmod!(dir, 0755)
    for n <- 1..4, do: create_file(dir, "file-" <> to_string(n))
    subdir = Path.join(dir, "subdir")
    File.mkdir!(subdir)
    File.chmod!(subdir, 0755)
    for n <- 1..4, do: create_file(dir, "subdir/file-" <> to_string(n))
    create_link(dir, "link1", "subdir/file-1")
    create_link(dir, "link2", "file-3")
    true
  end

  def create_file(dir, file) do
    File.write!(Path.join(dir, file), <<4, 3, 2, 1>>)
  end
end