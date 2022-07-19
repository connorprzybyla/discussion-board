//
//  CommentViewModel.swift
//  discussion-board
//
//  Created by Connor Przybyla on 7/18/22.
//

import Foundation

protocol CommentViewModelable {
    var likeTotal: Int { get }
    var dislikeTotal: Int { get }
    var commentDescription: String { get }
    var indentationLevel: Int { get }
}

class CommentViewModel: CommentViewModelable {
    let likeTotal: Int
    let dislikeTotal: Int
    let commentDescription: String
    let indentationLevel: Int
    
    init(
        likeTotal: Int,
        dislikeTotal: Int,
        commentDescription: String,
        indentationLevel: Int
    ) {
        self.likeTotal = likeTotal
        self.dislikeTotal = dislikeTotal
        self.commentDescription = commentDescription
        self.indentationLevel = indentationLevel
    }
}
