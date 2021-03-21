//
//  LowestCommonAncestor.swift
//  LowestCommonAncestor
//
//  Created by Yuki Tsukada on 2021/03/21.
//

import Foundation


var alreadyExist = [Int:Bool]()
var children: [[Int]] = []

func lowestCommonAncestor() {
    print("Please input vertices for lowestCommonAncestor")
    
    let preN = readLine()!.split(separator: " ").map { Int($0) }
    let n = preN[0]!
    children = Array(repeating: Array(repeating: 0, count: 0), count: n + 1)
    alreadyExist[1] = true
    for i in 2...n {
        alreadyExist[i] = false
    }
    
    for _ in 0..<n - 1 {
        
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        
        if alreadyExist[nodeInfo[0]!] == false {
            children[nodeInfo[1]!].append(nodeInfo[0]!)
            alreadyExist[nodeInfo[0]!] = true
        }
        if alreadyExist[nodeInfo[1]!] == false {
            children[nodeInfo[0]!].append(nodeInfo[1]!)
            alreadyExist[nodeInfo[1]!] = true
        }
    }
    
    let preM = readLine()!.split(separator: " ").map { Int($0) }
    let m = preM[0]!
    
    for _ in 0..<m {
        let nodeInfo = readLine()!.split(separator: " ").map { Int($0) }
        let p = nodeInfo[0]!
        let q = nodeInfo[1]!
        let LCA = lowestCommonAncestorHelper(root: 1, p: p, q: q)!
        print("Lowest Common Ancestor of \(p) and \(q) is \(LCA).")
    }
}


func lowestCommonAncestorHelper(root: Int, p: Int, q: Int) -> Int? {
    
    if root == p || root == q {
        // the root is the LCA
        return root
    }
    if children[root].isEmpty {
        // this root node is the dead end
        return nil
    }
    var count = 0
    var onlyFoundOne = 0
    for i in children[root] {
        if lowestCommonAncestorHelper(root: i, p: p, q: q) != nil {
            onlyFoundOne = lowestCommonAncestorHelper(root: i, p: p, q: q)!
            count += 1
        }
    }
    if count == 2 {
        // the root is the LCA
        return root
    } else if count == 1 {
        // LCA exists higher than this
        return onlyFoundOne
    } else {
        // nothing below this root node
        return nil
    }
}
