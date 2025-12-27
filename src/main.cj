package leetcode160

// 1. 实现 Equatable 接口以支持 Option 类型的 == 和 != 比较 [1]
class ListNode <: Equatable<ListNode> {
    var val: Int64
    var next: ?ListNode

    public init(val: Int64) {
        this.val = val
        this.next = None
    }

    public init(val: Int64, next: ?ListNode) {
        this.val = val
        this.next = next
    }

    // 2. 使用正确的内置函数 refEq 比较引用地址 [6]
    public operator func ==(that: ListNode): Bool {
        return refEq(this, that) 
    }

    public operator func !=(that: ListNode): Bool {
        return !refEq(this, that)
    }
}

func getIntersectionNode(headA: ?ListNode, headB: ?ListNode): ?ListNode {
    var pA = headA
    var pB = headB

    while (pA != pB) {
        // 3. 处理 Option 类型赋值
        if (pA == None) {
            pA = headB
        } else {
            // 使用 getOrThrow() 获取内部 String/ListNode 对象以访问成员 [2]
            // 这样返回的类型依然是 ?ListNode，避免了 ?. 导致的类型嵌套问题
            pA = pA.getOrThrow().next
        }

        if (pB == None) {
            pB = headA
        } else {
            pB = pB.getOrThrow().next
        }
    }

    return pA
}

main(): Int64 {
    // 构造测试数据
    let common = ListNode(8)
    let headA = ListNode(4, ListNode(1, common))
    let headB = ListNode(5, ListNode(6, ListNode(1, common)))

    // 调用函数以消除 unused 警告 [3]
    let result = getIntersectionNode(headA, headB)

    if (let Some(node) <- result) {
        println("Found intersection: ${node.val}")
    } else {
        println("No intersection")
    }

    return 0
}