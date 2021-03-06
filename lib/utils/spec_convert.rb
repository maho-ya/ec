# installation: brew install nkf
#
# todo_to_spec クリップボードにあるTODOリストをspecに変換してコンソールへ出力。
# spec_to_todo クリップボードにあるspecでの出力をTODOリストへ変換してコンソールへ出力。
#
# クリップボードに入れたい場合はプログラムコール時に | pbcopy をつける
class SpecConvert
  def spec_to_todo(checked = false)
    checked_text = if checked
                     'x'
                   else
                     ' '
                   end

    clipboard = `pbpaste | /usr/local/bin/nkf -w`
    clipboard.split(/\R/).each do |line|
      m = line.match(/\A(\s*)(.*)\z/)
      puts m[1] + '- [' + checked_text + '] ' + m[2]
    end
  end

  def todo_to_spec
    first_line_indent_size = -1
    previous_indent_size = 0

    clipboard = `pbpaste | /usr/local/bin/nkf -w`
    clipboard.split(/\R/).each do |line|
      if line.include?('- [ ] ')
        first_line_indent_size = line.index('-') if first_line_indent_size.negative?
        previous_indent_size = puts_spec(line, previous_indent_size)
      end
    end

    previous_indent_size -= 2
    previous_indent_size.step(first_line_indent_size, -2) do |indent_size|
      puts ' ' * indent_size + 'end'
    end
  end

  def puts_spec(line, previous_indent_size)
    line_index = line.index('-')

    if previous_indent_size.positive? && previous_indent_size > line_index
      (previous_indent_size - 2).step(line_index, -2) do |indent_size|
        puts ' ' * indent_size + 'end'
      end
    end

    previous_indent_size = line_index

    if /こと\Z/.match?(line)
      puts_spec_header(line, 'it')
    elsif /とき\Z/.match?(line)
      puts_spec_header(line, 'context')
    else
      puts_spec_header(line, 'describe')
    end

    previous_indent_size
  end

  def puts_spec_header(line, prefix_spec)
    space = ' ' * line.index('-')
    puts line.sub(/\- \[ \] /, prefix_spec + ' \'') << '\' do'
    puts space << 'end' if prefix_spec == 'it'
  end
end

if $PROGRAM_NAME == __FILE__
  spec_convert = SpecConvert.new

  case ARGV[0]
  when 'todo'  # RSpecの結果からTODOリストを出力
    spec_convert.spec_to_todo
  when 'todox' # RSpecの結果からチェックしたTODOリストを出力
    spec_convert.spec_to_todo(true)
  else         # TODOリストからRSpecを出力
    spec_convert.todo_to_spec
  end

end
