//
//  SearchRepositoryResponse.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/26.
//

import Foundation


struct SearchRepositoriesResponse: Codable {
    let total_count: Int64
    let incomplete_results: Bool
    
    let items: [SearchRepositoryResponse]
}


// TODO: nullable한 속성 확인 안됨
struct SearchRepositoryResponse: Codable {
    
    let id: Int64?             // 3081286,
    let node_id: String?       // "MDEwOlJlcG9zaXRvcnkzMDgxMjg2",
    let name: String?          // "Tetris",
    let full_name: String?     // "dtrupenn/Tetris",
    
    struct Owner: Codable {
        let login: String?               // "dtrupenn",
        let id: Int64              // 872147,
        let node_id: String?                 // "MDQ6VXNlcjg3MjE0Nw==",
        let avatar_url: String?              // "https://secure.gravatar.com/avatar/e7956084e75f239de85d3a31bc172ace?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
        let gravatar_id: String?             // "",
        let url: String?             // "https://api.github.com/users/dtrupenn",
        let received_events_url: String?             // "https://api.github.com/users/dtrupenn/received_events",
        let type: String?                // "User",
        let html_url: String?                // "https://github.com/octocat",
        let followers_url: String?               // "https://api.github.com/users/octocat/followers",
        let following_url: String?               // "https://api.github.com/users/octocat/following{/other_user}",
        let gists_url: String?               // "https://api.github.com/users/octocat/gists{/gist_id}",
        let starred_url: String?             // "https://api.github.com/users/octocat/starred{/owner}{/repo}",
        let subscriptions_url: String?               // "https://api.github.com/users/octocat/subscriptions",
        let organizations_url: String?               // "https://api.github.com/users/octocat/orgs",
        let repos_url: String?               // "https://api.github.com/users/octocat/repos",
        let events_url: String?              // "https://api.github.com/users/octocat/events{/privacy}",
        let site_admin: Bool?              // true
    }
    
    let owner: Owner?
    
    let `private`: Bool?                     //   false,
    let html_url: String?                  //  "https://github.com/dtrupenn/Tetris",
    let description: String?                   //   "A C implementation of Tetris using Pennsim through LC4",
    let fork: Bool?                    //  false,
    let url: String?                   //   "https://api.github.com/repos/dtrupenn/Tetris",
    let created_at: String?                    //    "2012-01-01T00:31:50Z",
    let updated_at: String?                    //    "2013-01-05T17:58:47Z",
    let pushed_at: String?                     //     "2012-01-01T00:37:02Z",
    let homepage: String?                  //  "https://github.com",
    let size: Int64?                   //  524,
    let stargazers_count: Int64?                   //  1,
    let watchers_count: Int64?                     //    1,
    let language: String?                  //  "Assembly",
    let forks_count: Int64?                    //   0,
    let open_issues_count: Int64?                  //     0,
    let master_branch: String?                     //     "master",
    let default_branch: String?                    //    "master",
    let score: Int64?                  //     1,
    let archive_url: String?                   //   "https://api.github.com/repos/dtrupenn/Tetris/{archive_format}{/ref}",
    let assignees_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/assignees{/user}",
    let blobs_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/git/blobs{/sha}",
    let branches_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/branches{/branch}",
    let collaborators_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/collaborators{/collaborator}",
    let comments_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/comments{/number}",
    let commits_url: String?                   //   "https://api.github.com/repos/dtrupenn/Tetris/commits{/sha}",
    let compare_url: String?                   //   "https://api.github.com/repos/dtrupenn/Tetris/compare/{base}...{head}",
    let contents_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/contents/{+path}",
    let contributors_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/contributors",
    let deployments_url: String?                   //   "https://api.github.com/repos/dtrupenn/Tetris/deployments",
    let downloads_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/downloads",
    let events_url: String?                    //    "https://api.github.com/repos/dtrupenn/Tetris/events",
    let forks_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/forks",
    let git_commits_url: String?                   //   "https://api.github.com/repos/dtrupenn/Tetris/git/commits{/sha}",
    let git_refs_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/git/refs{/sha}",
    let git_tags_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/git/tags{/sha}",
    let git_url: String?                   //   "git:github.com/dtrupenn/Tetris.git",
    let issue_comment_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/issues/comments{/number}",
    let issue_events_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/issues/events{/number}",
    let issues_url: String?                    //    "https://api.github.com/repos/dtrupenn/Tetris/issues{/number}",
    let keys_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/keys{/key_id}",
    let labels_url: String?                    //    "https://api.github.com/repos/dtrupenn/Tetris/labels{/name}",
    let languages_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/languages",
    let merges_url: String?                    //    "https://api.github.com/repos/dtrupenn/Tetris/merges",
    let milestones_url: String?                    //    "https://api.github.com/repos/dtrupenn/Tetris/milestones{/number}",
    let notifications_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/notifications{?since,all,participating}",
    let pulls_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/pulls{/number}",
    let releases_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/releases{/id}",
    let ssh_url: String?                   //   "git@github.com:dtrupenn/Tetris.git",
    let stargazers_url: String?                    //    "https://api.github.com/repos/dtrupenn/Tetris/stargazers",
    let statuses_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/statuses/{sha}",
    let subscribers_url: String?                   //   "https://api.github.com/repos/dtrupenn/Tetris/subscribers",
    let subscription_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/subscription",
    let tags_url: String?                  //  "https://api.github.com/repos/dtrupenn/Tetris/tags",
    let teams_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/teams",
    let trees_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/git/trees{/sha}",
    let clone_url: String?                     //     "https://github.com/dtrupenn/Tetris.git",
    let mirror_url: String?                    //    "git:git.example.com/dtrupenn/Tetris",
    let hooks_url: String?                     //     "https://api.github.com/repos/dtrupenn/Tetris/hooks",
    let svn_url: String?                   //   "https://svn.github.com/dtrupenn/Tetris",
    let forks: Int64?                  //     1,
    let open_issues: Int64?                    //   1,
    let watchers: Int64?                   //  1,
    let has_issues: Bool?                  //    true,
    let has_projects: Bool?                    //  true,
    let has_pages: Bool?                   //     true,
    let has_wiki: Bool?                    //  true,
    let has_downloads: Bool?                   //     true,
    let archived: Bool?                    //  true,
    let disabled: Bool?                    //  true,
    let visibility: String?                    //    "private",
    
    struct License: Codable {
        let key: String?             // "mit",
        let name: String?            // "MIT License",
        let url: String?             // "https://api.github.com/licenses/mit",
        let spdx_id: String?             // "MIT",
        let node_id: String?             // "MDc6TGljZW5zZW1pdA==",
        let html_url: String?            // "https://api.github.com/licenses/mit"
    }
    
    let license: License?
}
