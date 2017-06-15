from invoke import task
#from paramiko import SSHClient, AutoAddPolicy
#import os

@task
def init(ctx, environment):
    ctx.run("terraform init -var-file=./{}.tfvars".format(environment), pty=True)
    ctx.run("terraform env new {}".format(environment), pty=True)

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
