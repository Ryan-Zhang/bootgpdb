#!/usr/bin/env python

import boto3
import argparse

def display_instances(rc):
        ec2 = boto3.resource('ec2')
        #instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])
        l = 0
        for idx, n in enumerate(rc):
                l += 1
                n.wait_until_running()
                n.reload()
                if idx == 0 :
                        print ("mdw ansible_ssh_host={0}".format(n.public_ip_address))
                else:
                        print("sdw{0} ansible_ssh_host={1}".format(idx, n.public_ip_address))
                        #print(idx, n.id, n.public_ip_address, n.private_ip_address)

        for i in range(l):
                if i == 0: print ('[all]\nmdw')
                else:
                        print("sdw{0}".format(i))

'''
blockdevmap = [
    {
        'DeviceName': '/dev/xvdb',
        'Ebs': {
            'VolumeSize': instance['data'],
            'DeleteOnTermination': True,
        }
    }
]

rc = ec2.create_instances(
        ImageId = image,
        MinCount = 1,
        MaxCount = 1,
        KeyName = instance['key'],
        SecurityGroupIds = sg,
        InstanceType = instance['type'],
        BlockDeviceMappings = blockdevmap,
        SubnetId = subnet,
        PrivateIpAddress = instance['ipaddr']
)
'''

'''
rc = ec2.create_instances(
        ImageId = 'ami-05cf2265',
        MinCount = 1,
        MaxCount = 1,
        InstanceType = 't2.micro',
        KeyName = 'jasli',
        SecurityGroups = ['default']
        )

print rc
'''


'''
client = boto3.client('ec2')
n = client.describe_subnets()
print n
'''

if __name__ == "__main__":
        parser = argparse.ArgumentParser(description='Create VM on EC2')
        parser.add_argument('-n', '--num', type=int, default=1,
                            help='number of instances to create')

        parser.add_argument('-s', '--size', type=int, default=20,
                            help='size of EBS disk, in GB')

        parser.add_argument('-d', '--device', default='/dev/xvdb',
                            help='device name of EBS disk')

        parser.add_argument('-k', '--key', required=True,
                            help='key pair name')

        parser.add_argument('-t', '--type', default='t2.large',
                            help='instance type, xxx')

        parser.add_argument('-i', '--image', default='ami-05cf2265',
                            help='image id')

        args = parser.parse_args()

        ec2 = boto3.resource('ec2')
        
        blockdevmap = [
                {
                        'DeviceName': args.device,
                        'Ebs': {
                                'VolumeSize': args.size,
                                'DeleteOnTermination': True,
                        }
                }
        ]
        rc = ec2.create_instances(
        ImageId = args.image,
        MinCount = args.num,
        MaxCount = args.num,
        KeyName = args.key,
        #SecurityGroupIds = sg,
        InstanceType = args.type,
        BlockDeviceMappings = blockdevmap
        #SubnetId = subnet
        )

        if rc:
                display_instances(rc)
