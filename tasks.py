from invoke import task
#from paramiko import SSHClient, AutoAddPolicy
#import os

@task
def init(ctx, environment):
    print(environment)
    cmd = "terraform init -var-file=./{}.tfvars".format(environment)
    print(cmd)
    ctx.run(cmd, pty=True)
    cmd = "terraform env new {}".format(environment)
    ctx.run(cmd, pty=True)

# @task
# def test(ctx):
#     ctx.run("bundle exec rspec spec", pty=True)
#
# @task
# def plan(ctx):
#     ctx.run("terraform get", pty=True)
#     ctx.run("terraform plan -var-file=./bootstrap.tfvars", pty=True)
#
# @task
# def apply(ctx):
#     ctx.run("terraform apply -var-file=./bootstrap.tfvars", pty=True)
