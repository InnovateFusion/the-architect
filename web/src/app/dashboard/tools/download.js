import { DownloadCloudIcon, DownloadIcon } from "lucide-react";
import Link from "next/link";

export default function Download(props) {
  // if (!props.predictions.length) return null;

  // const lastPrediction = props.predictions[props.predictions.length - 1];

  // if (!lastPrediction.output) return null;

  // const lastImage = lastPrediction.output[lastPrediction.output.length - 1];

  return (
    <Link
      href={props.lastImage}
      className="lil-button btn bg-blue-500 flex gap-2"
      target="_blank"
      rel="noopener noreferrer"
      download
    >
      <DownloadCloudIcon /> {" "}
       Download
    </Link>
  );
}
