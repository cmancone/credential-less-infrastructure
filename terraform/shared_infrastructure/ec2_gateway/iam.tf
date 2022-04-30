data "aws_iam_policy_document" "instance_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "instance_role" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.instance_role.json
  tags = merge(var.tags, {
    "Name" = var.iam_role_name
  })
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = var.iam_role_name
  path = "/"
  role = var.iam_role_name
}

data "aws_iam_policy_document" "assume_admin" {
  statement {
    sid       = "AssumeAdmin"
    effect    = "Allow"
    actions   = ["sts:AssumeRole"]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "assume_admin" {
  name   = "assume-admin"
  role   = aws_iam_role.instance_role.id
  policy = data.aws_iam_policy_document.assume_admin.json
}

data "aws_iam_policy" "ssm" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "sto-readonly-role-policy-attach" {
  role       = aws_iam_role.instance_role.id
  policy_arn = data.aws_iam_policy.ssm.arn
}
