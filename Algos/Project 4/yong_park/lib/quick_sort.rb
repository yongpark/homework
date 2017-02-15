class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    pivot = rand(array.length)
    array[0] = array[pivot]
    arr[pivot] = arr[0]
    left = array.select{|el| pivot > el}
    middle = array.select{|el| pivot == el}
    right = array.select { |el| pivot < el }
    sort1(left) + middle + sort1(right)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    prc ||= Proc.new{|num1, num2| num1 <=> num2}
    pivot = partition(array, start, length, &prc)
    left = pivot - start
    right = length - (left + 1)
    sort2!(array, start, left, &prc)
    sort2!(array, pivot + 1, right, &prc)
    array
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    pivot = start
    pivot_num = array[start]
    ((start + 1)...(start + length)).each do |idx|
      if prc.call(pivot_num, array[idx]) > 0
        array[idx], array[pivot + 1] = array[pivot + 1], array[idx]
        pivot += 1
      end
    end
    array[start], array[pivot] = array[pivot], array[start]
    pivot
  end
end
