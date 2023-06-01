resource "null_resource" "user_data" {
  provisioner "local-exec" {
    command     = "rm -f ./files/user_data.sh && echo $FILE_HEADER >> ./files/user_data.sh && cat ./files/parts/*.sh >> ./files/user_data.sh"
    interpreter = ["/bin/bash", "-c"]
    working_dir = path.module
    environment = {
      FILE_HEADER = "#!/bin/bash"
    }
    on_failure = fail
  }
}

data "null_data_source" "this" {
  inputs = {
    user_data = "${path.module}/files/user_data.sh"
  }

  depends_on = [ null_resource.user_data ]
}