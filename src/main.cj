package leetcode160
// import 语句必须位于文件最顶部 [2]
import std.collection.*
import std.env.* // 用于终端输入输出 [1][4]
import std.convert.* // 用于字符串转数值

// 定义二叉树节点
public class BinaryTreeNode {
    public var val: Int64
    public var left: ?BinaryTreeNode = None
    public var right: ?BinaryTreeNode = None
    public init(val: Int64) {
        this.val = val

    }
}

class Solution {
    // 中序遍历主函数
    public func inorderTraversal(root: ?BinaryTreeNode): ArrayList<Int64> {
        let result = ArrayList<Int64>()
        dfs(root, result)
        return result
    }

    // 递归辅助函数
    private func dfs(node: ?BinaryTreeNode, res: ArrayList<Int64>): Unit {
        match (node) {
            case Some(n) => 
                dfs(n.left, res)
                res.add(n.val)
                dfs(n.right, res)
            case None => ()
        }
    }
}

// 辅助函数：根据终端输入的层序遍历字符串构建二叉树
func buildTree(input: String): ?BinaryTreeNode {
    let nodes = input.split(",")
    if (nodes.size == 0 || nodes[0] == "null" || nodes[0] == "") {
        return None
    }

    let root = BinaryTreeNode(Int64.parse(nodes[0]))
    let queue = ArrayList<?BinaryTreeNode>()
    queue.add(root)
    
    var i = 1
    var j = 0
    while (i < nodes.size) {
        let parent = queue[j]
        j++

        match (parent) {
            case Some(p) =>
                // 左孩子
                if (i < nodes.size && nodes[i] != "null") {
                    let leftNode = BinaryTreeNode(Int64.parse(nodes[i]))
                    p.left = leftNode
                    queue.add(leftNode)
                }
                i++
                // 右孩子
                if (i < nodes.size && nodes[i] != "null") {
                    let rightNode = BinaryTreeNode(Int64.parse(nodes[i]))
                    p.right = rightNode
                    queue.add(rightNode)
                }
                i++
            case None => ()
        }
    }
    return root
}

main() {
    let stdout = getStdOut() // 获取标准输出实例 [4]
    let stdin = getStdIn()   // 获取标准输入实例 [4]

    stdout.write("请输入层序遍历的二叉树节点（用逗号隔开，空节点用null表示，如 1,2,3,null,null,4）：\n")
    
    // 从标准输入读取一行 [1][6]
    match (stdin.readln()) {
        case Some(input) =>
            let root = buildTree(input)
            let solution = Solution()
            let result = solution.inorderTraversal(root)
            
            stdout.write("中序遍历结果为：")
            stdout.writeln(result.toString()) // 打印 ArrayList 结果 [3]
        case None => 
            stdout.writeln("未获取到输入")
    }
}
