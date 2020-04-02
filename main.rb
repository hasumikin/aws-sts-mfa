#! /usr/bin/env ruby

require "yaml"
require "json"
require "open3"

if  ARGV[0].nil? || %w(--help -h --usage).include?(ARGV[0])
  puts "Usage: aws-sts-mfa [pofile_name] [MFA token] && . ~/.awsrc"
  exit
end

yaml = YAML.load_file File.expand_path("../config.yml", File.realpath(__FILE__))
config = yaml.find do |y|
  y["profile"] == ARGV[0]
end
if config.nil?
  puts "profile not found. check config.yml"
  exit
end

profile = config["profile"]
mfa_arn = config["mfa_arn"]

if ARGV[1].nil?
  puts "MFA token not provided"
  exit
end

mfa_token = ARGV[1]

if %w(clear reset delete remove).include?(mfa_token)
  Open3.capture3("echo 'unset AWS_ACCESS_KEY_ID'      > ~/.awsrc")
  Open3.capture3("echo 'unset AWS_SECRET_ACCESS_KEY' >> ~/.awsrc")
  Open3.capture3("echo 'unset AWS_SESSION_TOKEN'     >> ~/.awsrc")
  puts Open3.capture3("cat ~/.awsrc")
  puts
  puts "please run manually: . ~/.awsrc"
  exit
end

cmd =<<~EOF
aws --profile #{profile} \
sts get-session-token \
--serial-number #{mfa_arn} \
--token-code #{mfa_token} \
--duration-seconds 129600
EOF

begin
  stdout, stderr, status = Open3.capture3(cmd)
  obj = JSON.parse(stdout)
  Open3.capture3("echo 'export AWS_ACCESS_KEY_ID=#{obj["Credentials"]["AccessKeyId"]}'          > ~/.awsrc")
  Open3.capture3("echo 'export AWS_SECRET_ACCESS_KEY=#{obj["Credentials"]["SecretAccessKey"]}' >> ~/.awsrc")
  Open3.capture3("echo 'export AWS_SESSION_TOKEN=#{obj["Credentials"]["SessionToken"]}'        >> ~/.awsrc")
  puts Open3.capture3("cat ~/.awsrc")
  puts
  puts "please run manually: . ~/.awsrc"
rescue => e
  p e
  puts stderr
  p status
end
