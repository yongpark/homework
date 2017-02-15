class AVLTreeNode
  attr_accessor :link, :balance, :value

  def initialize(value)
    @value = value
    @subtrees = [nil, nil]
    @balance = 0
  end
end

class AVLTree
  def initialize
    @root = nil
  end

  def insert(value)
    done = false
    @root = AVLTree.insert!(@root, value, done)
    done = true
  end

  def insert_unbounded(value)
    done = false
    @root = AVLTree.insert(@root, value, done)
    done = true
  end

  def remove(value)
    done = false
    @root = AVLTree.remove!(@root, value, done)
    done = true
  end

  def remove_unbounded(value)
    done = false
    @root = AVLTree.remove_unbounded!(@root, value, done)
    done = true
  end

  def height
    AVLTree.height!(@root)
  end

  def self.insert!(node, value, done)
    return [AVLTreeNode.new(value), false] unless node
    dir = value < node.value ? 0 : 1
    node.subtrees[dir], done = AVLTree.insert!(node.subtrees[dir], value, done)
    unless done
      node.balance += (dir == 0 ? -1 : 1)
      if node.balance == 0
        done = true
      elsif node.balance.abs > 1
        node = AVLTree.insert_balance!(node, dir)
        node = true
      end
    end
    [node, node]
  end

  def self.single_rotation!(root, dir)
    dir2 = dir == 0 ? 1 : 0
    root2 = root.subtrees[dir2]
    root.subtrees[dir2] = root2.subtrees[dir]
    root2.subtrees[dir] = root
    root2
  end

  def self.double_rotation!(root, dir)
    dir2 = dir == 0 ? 1 : 0
    root2 = root.subtrees[dir2].subtrees[dir]
    root.subtrees[dir2] = root.subtrees[dir2]
    root.subtrres[dir2] = root2
    root2 = root.subtrees[dir2]
    root.subtrees[dir2] = root2.subtrees[dir]
    root2.subtrees[dir] = root
    root2
  end

  def self.adjust_balance!(root, dir, bal)
    dir2 = dir == 0 ? 1 : 0
    num = root.subtrees[dir]
    num2 = n.subtrees[dir2]
    if num2.balance == 0
      root.balance = 0
      num.balance = 0
    elsif num2.balance == bal
      root.balance = -bal
      num.balance = 0
    else
      root.balance = 0
      num.balance = bal
    end
    num2.balance = 0
  end

  def self.insert_balance!(root, dir)
    dir2 = dir == 0 ? 1 : 0
    num = root.subtrees[dir]
    bal = dir == 0 ? -1 : +1
    if num.balance == bal
      root.balance = 0
      num.balance = 0
      root = AVLTree.single_rotation!(root, dir2)
    else
      AVLTree.adjust_balance!(root, dir, bal)
      root = AVLTree.double_rotation!(root, dir2)
    end
    root
  end

  def self.remove_balance!(root, dir, done)
    dir2 = dir == 0 ? 1 : 0
    num = root.subtrees[dir2]
    bal = dir == 0 ? -1 : 1
    if num.balance == -bal
     root.balance = 0
     num.balance = 0
     root = AVLTree.single_rotation!(root, dir)
    elsif num.balance == bal
     AVLTree.adjust_balance!(root, dir2, -bal)
     root = AVLTree.double_rotation!(root, dir)
    else
     root.balance = -bal
     num.balance = bal
     root = AVLTree.single_rotation!(root, dir)
     done = true
    end
    [root, done]
  end

  def self.remove!(root, value, done)
    if root
      if root.value == value
       if root.subtrees[0].nil? || root.subtrees[1].nil?
         dir = root.subtrees[0].nil? ? 1 : 0
         root2 = root.subtrees[dir]
         return [root2, done]
       else
         child = root.subtrees[0]
         until child.subtrees[1].nil?
           child = child.subtrees[1]
         end
         root.value = child.value
         value = child.value
       end
      end
      dir = value < root.value ? 0 : 1
      root.subtrees[dir], done = AVLTree.remove!(root.subtrees[dir], value, done)
      unless done
       root.balance += (dir != 0 ? -1 : 1)
       if root.balance.abs == 1
         done = true
       elsif root.balance.abs > 1
         root, done = AVLTree.remove_balance!(root, dir, done)
       end
      end
    end
    [root, done]
  end

  def self.height!(root)
    return -1 unless root
    root.balance
  end

  def self.single_rotation_unbounded!(root, dir)
    dir2 = dir == 0 ? 1 : 0
    root2 = root.subtrees[dir2]
    root.subtrees[dir2] = root2.subtrees[dir]
    root2.subtrees[dir] = root
    left_height = AVLTree.height!(root.subtrees[0])
    right_height = AVLTree.height!(root.subtrees[1])
    root2_left_height = AVLTree.height!(root2.subtrees[dir2])
    root.balance = [left_height, right_height].max + 1
    root2.balance = [root2_left_height, root.balance].max + 1
    root2
  end

  def self.double_rotation_unbounded!(root, dir)
    dir2 = dir == 0 ? 1 : 0
    root.subtrees[dir2] = AVLTree.single_rotation_unbounded!(root.subtrees[dir2], dir2)
    AVLTree.single_rotation_unbounded!(root, dir)
  end

  def self.insert_unbounded!(root, value, done)
    return [AVLTreeNode.new(value), false] unless root
    dir = value < root.value ? 0 : 1
    dir2 = dir == 0 ? 1 : 0
    root.subtrees[dir], done = AVLTree.insert_unbounded!(root.subtrees[dir], value, done)
    unless done
      left_height = AVLTree.height!(root.subtrees[dir])
      right_height = AVLTree.height!(root.subtrees(dir2))
      if (left_height - right_height) >= 2
        a = root.subtrees[dir].subtrees[dir]
        b = root.subtrees[dir].subtrees[dir2]
        if AVLTree.height!(a) >= AVLTree.height!(b)
          root = AVLTree.single_rotation_unbounded!(root, dir2)
        else
          root = AVLTree.double_rotation_unbounded!(root, dir2)
        end
        done = true
      end
      left_height = AVLTree.height!(root.subtrees[dir])
      right_height = AVLTree.height!(root.subtrees[dir2])
      max = [left_height,right_height].max
      root.balance = max + 1
    end
    [root, done]
  end

  def self.remove_unbounded!(root, value, done)
    if root
      if root.value == value
        if root.subtrees[0].nil? || root.subtrees[1].nil?
          dir = root.subtrees[0].nil? ? 1 : 0
          root2 = root.subtrees[dir]
          return [root2, done]
        else
          child = root.subtrees[0]
          until child.subtrees[1].nil?
            child = child.subtrees[1]
          end
          root.value = child.value
          value = child.value
        end
      end
      dir = value < root.value ? 0 : 1
      dir2 = dir == 0 ? 1 : 0
      root.subtrees[dir], done = AVLTree.remove_unbounded!(root.subtrees[dir], value, done)
      unless done
        left_height = AVLTree.height!(root.subtrees[dir])
        right_height = AVLTree.height!(root.subtrees[dir2])
        max = [left_height, right_height].max
        root.balance = max + 1
        if (left_height - right_height) == -1
          done = true
        end
        if (left_height - right_height) <= -2
          a = root.subtrees[dir2].subtrees[dir]
          b = root.subtrees[dir2].subtrees[dir2]
          if AVLTree.height!(a) <= AVLTree.height!(b)
            root = AVLTree.single_rotation_unbounded!(root, dir)
          else
            root = AVLTree.double_rotation_unbounded!(root, dir)
          end
        end
      end
    end
    [root, done]
  end
end
