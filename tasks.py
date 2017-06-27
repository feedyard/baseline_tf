from invoke import task
#from paramiko import SSHClient, AutoAddPolicy
import os


@task
def new(ctx, environment):
    ctx.run("terraform init -var-file=./{}.tfvars".format(environment), pty=True)
    ctx.run("terraform env new {}".format(environment), pty=True)


@task
def init(ctx, environment):
    ctx.run("terraform init -var-file=./{}.tfvars".format(environment), pty=True)
    ctx.run("terraform env select {}".format(environment), pty=True)

@task
def test(ctx, environment):
    ctx.run("bundle exec rspec spec", pty=True)

@task
def plan(ctx, environment):
    ctx.run("terraform get", pty=True)
    ctx.run("terraform plan -var-file=./{}.tfvars".format(environment), pty=True)

@task
def apply(ctx, environment):
    ctx.run("terraform apply -var-file=./{}.tfvars".format(environment), pty=True)