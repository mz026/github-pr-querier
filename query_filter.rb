module QueryFilter
  config = YAML.load_file("#{__dir__}/.credentials.yml")
  REPO_OWNER = config['repo_owner']
  USERNAME = config['username']

  FILTER_MAP = {
    to_be_merged: ["user:#{REPO_OWNER} author:#{USERNAME} type:pr state:open review:approved"],
    my_reviewed_prs: [
      "user:#{REPO_OWNER} author:#{USERNAME} type:pr state:open review:changes_requested",
      "user:#{REPO_OWNER} author:#{USERNAME} type:pr state:open comments:>1 review:none"
    ],
    pending_reviews: ["user:#{REPO_OWNER} type:pr state:open review-requested:#{USERNAME}"]
  }

  def self.get_queries type
    FILTER_MAP[type]
  end
end
