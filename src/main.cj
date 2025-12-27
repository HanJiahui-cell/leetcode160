package leetcode160

/**
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int64
 *     public var next: ?ListNode
 *     public init() {
 *         val = 0
 *         next = None
 *     }
 *     public init(val: Int64) {
 *         this.val = val
 *         next = None
 *     }
 * }
 */

class Solution {
    func reverseList(head: ?ListNode): ?ListNode {
        var prev: ?ListNode = None // 初始前驱节点为空 [2]
        var curr = head

        // 使用 while 配合模式匹配解构 Option 类型，遍历链表 [5]
        while (let Some(node) <- curr) {
            let nextNode = node.next   // 1. 临时保存当前节点的下一个节点，防止断链 [5]
            node.next = prev           // 2. 将当前节点指向前一个节点，实现反转
            prev = curr                // 3. prev 指针向后移动
            curr = nextNode            // 4. curr 指针向后移动
        }

        return prev // 最终 prev 指向原链表的尾节点，即新链表的头节点
    }
}
