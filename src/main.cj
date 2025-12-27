package leetcode160

import std.console.* // 用于终端输入输出
import std.convert.* // 用于字符串转数值

// 定义链表节点
class ListNode {
    public var val: Int64
    public var next: ?ListNode
    public init(val: Int64) {
        this.val = val
        this.next = None
    }
}

class Solution {
    public func isPalindrome(head: ?ListNode): Bool {
        // 使用 match 显式处理 None，规避类型推导错误 [5][6]
        let h = match (head) {
            case None => return true
            case Some(v) => v
        }
        
        // 模式匹配处理 next 节点，避免使用未实现 Equatable 的 == 判等 [2]
        if (let None <- h.next) {
            return true
        }

        // 1. 快慢指针找中点
        var slow: ?ListNode = head
        var fast: ?ListNode = head
        while (let Some(f) <- fast) {
            if (let Some(nxt) <- f.next) {
                fast = nxt.next
                if (let Some(s) <- slow) {
                    slow = s.next
                }
            } else {
                break
            }
        }

        // 2. 反转后半部分
        var prev: ?ListNode = None
        var curr = slow
        while (let Some(node) <- curr) {
            let nextNode = node.next
            node.next = prev
            prev = curr
            curr = nextNode
        }

        // 3. 比较数值
        var left = head
        var right = prev
        var result = true
        while (let Some(rNode) <- right) {
            if (let Some(lNode) <- left) {
                if (lNode.val != rNode.val) {
                    result = false
                    break
                }
                left = lNode.next
                right = rNode.next
            } else {
                break
            }
        }
        return result
    }
}

// 主函数：支持终端输入
main() {
    println("请输入链表数值（以空格隔开，按回车结束）：")
    let input = Console.stdIn.readln()
    
    match (input) {
        case Some(line) =>
            let nums = line.split(" ", removeEmpty: true)
            if (nums.size == 0) {
                println("结果: true (空链表)")
                return 0
            }

            // 根据输入数组构建链表
            let dummy = ListNode(0)
            var cur = dummy
            for (numStr in nums) {
                try {
                    let val = Int64.parse(numStr)
                    let newNode = ListNode(val)
                    cur.next = newNode
                    cur = newNode
                } catch (e: Exception) {
                    continue
                }
            }

            // 调用算法并输出
            let sol = Solution()
            let result = sol.isPalindrome(dummy.next)
            println("是否回文: ${result}")

        case None => println("未检测到输入")
    }
    return 0
}

